package examples

import (
	context "context"

	"github.com/yedf/dtm/dtmcli/dtmimp"
	"github.com/yedf/dtm/dtmgrpc"
	"google.golang.org/protobuf/types/known/emptypb"
)

func init() {
	addSample("grpc_xa", func() string {
		gid := dtmgrpc.MustGenGid(DtmGrpcServer)
		req := &BusiReq{Amount: 30}
		err := XaGrpcClient.XaGlobalTransaction(gid, func(xa *dtmgrpc.XaGrpc) error {
			r := &emptypb.Empty{}
			err := xa.CallBranch(req, BusiGrpc+"/examples.Busi/TransOutXa", r)
			if err != nil {
				return err
			}
			err = xa.CallBranch(req, BusiGrpc+"/examples.Busi/TransInXa", r)
			return err
		})
		dtmimp.FatalIfError(err)
		return gid
	})
}

func (s *busiServer) XaNotify(ctx context.Context, in *emptypb.Empty) (*emptypb.Empty, error) {
	return XaGrpcClient.HandleCallback(ctx)
}
